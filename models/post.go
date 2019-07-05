package models

import (
	"time"
)

// Post Models
type Post struct {
	ID          uint       `json:"id" gorm:"primary_key"`
	Name        string     `json:"name" gorm:"type:varchar(255)"`
	Description string     `json:"description"  gorm:"type:text"`
	Tags        []Tag      `json:"tags"` // One-To-Many relationship (has many - use Tag's UserID as foreign key)
	CreatedAt   time.Time  `json:"created_at"`
	UpdatedAt   time.Time  `json:"updated_at"`
	DeletedAt   *time.Time `json:"deleted_at"`
}

// Tag Models
type Tag struct {
	ID          uint       `json:"id" gorm:"primary_key"`
	PostID      uint       `gorm:"index"` // Foreign key (belongs to)
	Name        string     `json:"Name" gorm:"type:varchar(255)"`
	Description string     `json:"Description" gorm:"type:text"`
	CreatedAt   time.Time  `json:"created_at"`
	UpdatedAt   time.Time  `json:"updated_at"`
	DeletedAt   *time.Time `json:"deleted_at"`
}
