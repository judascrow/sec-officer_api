package models

import (
	"time"
)

// User Models
type User struct {
	ID        uint       `json:"id" gorm:"primary_key"`
	Username  string     `json:"username" gorm:"type:varchar(255)"`
	Password  string     `json:"password" gorm:"type:varchar(255)"`
	FirstName string     `json:"first_name" gorm:"type:varchar(255)"`
	LastName  string     `json:"last_name" gorm:"type:varchar(255)"`
	CreatedAt time.Time  `json:"created_at"`
	UpdatedAt time.Time  `json:"updated_at"`
	DeletedAt *time.Time `json:"deleted_at"`
}
