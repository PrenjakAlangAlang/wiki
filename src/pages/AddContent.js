import React from 'react';
import ConfirmationCard from '../components/ConfirmationCard';

const AddContent = () => {
    return (
        <div>
            {/* Other content of the AddContent page */}
            <h1>Add Content</h1>
            {/* Section for user confirmation */}
            <div>
                <ConfirmationCard />
            </div>
        </div>
    );
};

export default AddContent;