package models

import (
	"time"
)

// Role Models
type Role struct {
	ID          uint       `json:"id" gorm:"primary_key"`
	Name        string     `json:"name" gorm:"type:varchar(255);unique;not null"`
	Description string     `json:"description" gorm:"type:varchar(255)"`
	CreatedUid  int        `json:"created_uid" gorm:"type:int"`
	CreatedAt   time.Time  `json:"created_at"`
	CUpdatedUid int        `json:"updated_uid" gorm:"type:int"`
	UpdatedAt   time.Time  `json:"updated_at"`
	DeletedAt   *time.Time `json:"deleted_at"`
}
