package models

import (
	"backend/config"
	"backend/entities"
	"database/sql"
	"fmt"
	"time"
)

type ContentModel struct {
	conn *sql.DB
}

func NewContentModel() *ContentModel {
	conn, err := config.DBConnection()
	if err != nil {
		panic(err)
	}
	return &ContentModel{
		conn: conn,
	}
}

func (p *ContentModel) FindAll() ([]entities.Content, error) {
    query := "SELECT id, title FROM content WHERE status = 'approved'"
    rows, err := p.conn.Query(query)
    if err != nil {
        return []entities.Content{}, err
    }
    defer rows.Close()

    var dataContent []entities.Content
    for rows.Next() {
        var content entities.Content
        err := rows.Scan(&content.Id, &content.Title)
        if err != nil {
            return []entities.Content{}, err
        }
        dataContent = append(dataContent, content)
    }
    return dataContent, nil
}

func (p *ContentModel) FindNotRejected() ([]entities.Content, error) {
    query := `
        SELECT c.id, c.title, c.description, c.author_id, c.instance_id, 
               c.created_at, c.updated_at, c.tag, c.status, c.view_count, 
               c.rejection_reason, u.name as author_name
        FROM content c 
        LEFT JOIN user u ON c.author_id = u.id 
    `
    rows, err := p.conn.Query(query)
    if err != nil {
        return []entities.Content{}, err
    }
    defer rows.Close()

    var dataContent []entities.Content
    for rows.Next() {
        var content entities.Content
        err := rows.Scan(
            &content.Id, &content.Title, &content.Description, &content.Author_id, 
             &content.Instance_id, &content.Created_at, 
            &content.Updated_at, &content.Tag, &content.Status, &content.ViewCount, &content.Rejection_reason, 
            &content.Author_name,
        )
        if err != nil {
            return []entities.Content{}, err
        }
        dataContent = append(dataContent, content)
    }
    return dataContent, nil
}



func (p *ContentModel) FindNotDelete() ([]entities.Content, error) {
    query := "SELECT id, title FROM content WHERE status = 'approved' AND deleted_at IS NULL"
    rows, err := p.conn.Query(query)
    if err != nil {
        return []entities.Content{}, err
    }
    defer rows.Close()

    var dataContent []entities.Content
    for rows.Next() {
        var content entities.Content
        err := rows.Scan(&content.Id, &content.Title)
        if err != nil {
            return []entities.Content{}, err
        }
        dataContent = append(dataContent, content)
    }
    return dataContent, nil
}

func (p *ContentModel) FindDrafts() ([]entities.Content, error) {
	query := `
        SELECT c.id, c.description, c.title, c.author_id, u.name as author_name 
        FROM content c 
        LEFT JOIN user u ON c.author_id = u.id 
        WHERE c.status = 'pending'`
	rows, err := p.conn.Query(query)
	if err != nil {
		return []entities.Content{}, err
	}
	defer rows.Close()

	var dataContent []entities.Content
	for rows.Next() {
		var content entities.Content
		var authorName string
		err := rows.Scan(&content.Id, &content.Description, &content.Title, &content.Author_id, &authorName)
		if err != nil {
			return []entities.Content{}, err
		}
		content.Author_name = authorName // Add the author name to content
		dataContent = append(dataContent, content)
	}
	return dataContent, nil
}

func (model *ContentModel) Search(searchTerm string) ([]entities.Content, error) {
	var contents []entities.Content

	query := `SELECT id, title, description, author_id, instance_id, created_at, updated_at, tag, status 
              FROM content 
              WHERE (title LIKE ? OR tag LIKE ?) AND status = 'approved'`

	searchTerm = "%" + searchTerm + "%"

	rows, err := model.conn.Query(query, searchTerm, searchTerm)
	if err != nil {
		return nil, fmt.Errorf("error executing search query: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		var content entities.Content
		if err := rows.Scan(&content.Id, &content.Title, &content.Description, &content.Author_id,
			&content.Instance_id, &content.Created_at, &content.Updated_at, &content.Tag, &content.Status); err != nil {
			return nil, fmt.Errorf("error scanning result: %v", err)
		}
		contents = append(contents, content)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("rows iteration error: %v", err)
	}

	return contents, nil
}

func (p *ContentModel) UpdateByID(content entities.Content) error {
	query := `
        UPDATE content 
        SET title = ?, description = ?, updated_at = ?, instance_id = ?, tag = ? 
        WHERE id = ?`

	_, err := p.conn.Exec(query, content.Title, content.Description, content.Updated_at, content.Instance_id, content.Tag, content.Id)
	return err
}

func (p *ContentModel) CreateContent(content entities.Content) (int64, error) {
	query := `
        INSERT INTO content (title, description, author_id, created_at, updated_at, tag, instance_id, status) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)`

	result, err := p.conn.Exec(query, content.Title, content.Description, content.Author_id, content.Created_at, content.Updated_at, content.Tag, content.Instance_id, content.Status)
	if err != nil {
		return 0, err
	}

	contentID, err := result.LastInsertId()
	if err != nil {
		return 0, err
	}
	return contentID, nil
}

func (p *ContentModel) DeleteByID(contentID int64) error {
    // Load WIB timezone
    loc, err := time.LoadLocation("Asia/Jakarta")
    if err != nil {
        return fmt.Errorf("error loading Asia/Jakarta timezone: %w", err)
    }

    // Get current time in WIB and format as string
    nowWIB := time.Now().In(loc).Format("2006-01-02 15:04:05")

    // Debug: Log the WIB time
    fmt.Printf("Waktu WIB yang dikirim: %v\n", nowWIB)

    // Prepare the query to update the deleted_at column
    query := "UPDATE content SET deleted_at = ? WHERE id = ? AND deleted_at IS NULL"
    result, err := p.conn.Exec(query, nowWIB, contentID)
    if err != nil {
        return fmt.Errorf("error soft deleting content: %w", err)
    }

    // Check rows affected
    rowsAffected, err := result.RowsAffected()
    if err != nil {
        return fmt.Errorf("error retrieving rows affected: %w", err)
    }
    if rowsAffected == 0 {
        return fmt.Errorf("no rows were updated, possibly contentID does not exist or already deleted")
    }

    return nil
}


func (p *ContentModel) FindByIDWithAuthorName(id int64) (*entities.Content, string, error) {
	query := `
        SELECT c.id, c.title, c.description, c.author_id, c.instance_id, c.created_at, c.updated_at, c.tag, u.name AS author_name
        FROM content c
        LEFT JOIN user u ON c.author_id = u.id
        WHERE c.id = ?`
	row := p.conn.QueryRow(query, id)

	var content entities.Content
	var authorName string
	err := row.Scan(&content.Id, &content.Title, &content.Description, &content.Author_id, &content.Instance_id, &content.Created_at, &content.Updated_at, &content.Tag, &authorName)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, "", nil
		}
		return nil, "", err
	}
	return &content, authorName, nil
}

func (s *ContentModel) GetContentsByAuthorId(authorId int64) ([]entities.Content, error) {
	var contents []entities.Content
	query := `SELECT id, title, created_at, updated_at, author_id, status, rejection_reason FROM content WHERE author_id = ?`
	rows, err := s.conn.Query(query, authorId)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var content entities.Content
		if err := rows.Scan(&content.Id, &content.Title, &content.Created_at, &content.Updated_at, &content.Author_id, &content.Status, &content.Rejection_reason); err != nil {
			return nil, err
		}
		contents = append(contents, content)
	}
	return contents, nil
}



func (m *ContentModel) UpdateStatus(contentID int, status string) error {
	query := "UPDATE content SET status = ? WHERE id = ?"
	_, err := m.conn.Exec(query, status, contentID)
	return err
}

func (p *ContentModel) GetViewCountByContentID(contentID int) (int, error) {
    var viewCount int
    query := "SELECT view_count FROM content WHERE id = ?"
    err := p.conn.QueryRow(query, contentID).Scan(&viewCount)
    if err != nil {
        return 0, err
    }
    return viewCount, nil
}

func (p *ContentModel) IncrementViewCount(contentID int) error {
    query := "UPDATE content SET view_count = view_count + 1 WHERE id = ?"
    _, err := p.conn.Exec(query, contentID)
    return err
}

func (p *ContentModel) RejectContent(contentID int, reason string) error {
    query := `
        UPDATE content 
        SET status = 'rejected', 
            rejection_reason = ?, 
            updated_at = CURRENT_TIMESTAMP 
        WHERE id = ?
    `
    
    result, err := p.conn.Exec(query, reason, contentID)
    if err != nil {
        return fmt.Errorf("failed to execute query: %v", err)
    }

    rowsAffected, err := result.RowsAffected()
    if err != nil {
        return fmt.Errorf("failed to get rows affected: %v", err)
    }

    if rowsAffected == 0 {
        return fmt.Errorf("no content found with ID %d", contentID)
    }

    return nil
}

