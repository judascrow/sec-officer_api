package models

import (
	"time"
)

// Role Models
type Court struct {
	ID         uint       `json:"id" gorm:"primary_key"`
	CourtCode  string     `json:"court_code" gorm:"type:varchar(10);unique;not null"`
	Name       string     `json:"name" gorm:"type:varchar(255);not null"`
	CreatedUid int        `json:"created_uid" gorm:"type:int"`
	CreatedAt  time.Time  `json:"created_at"`
	UpdatedUid int        `json:"updated_uid" gorm:"type:int"`
	UpdatedAt  time.Time  `json:"updated_at"`
	DeletedAt  *time.Time `json:"deleted_at"`
}
