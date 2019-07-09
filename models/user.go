package models

import (
	"time"
)

// User Models
type User struct {
	ID         uint       `json:"id" gorm:"primary_key"`
	Username   string     `json:"username" gorm:"type:varchar(255);unique;not null"`
	Password   string     `json:"password" gorm:"type:varchar(255)"`
	FirstName  string     `json:"first_name" gorm:"type:varchar(255)"`
	LastName   string     `json:"last_name" gorm:"type:varchar(255)"`
	RoleID     int        `json:"role_id" gorm:"type:int"`
	Role       Role       `json:"role" gorm:"foreignkey:id;association_foreignkey:RoleID;PRELOAD:true"`
	CourtID    int        `json:"court_id" gorm:"type:int"`
	CreatedUid int        `json:"created_uid" gorm:"type:int"`
	CreatedAt  time.Time  `json:"created_at"`
	UpdatedUid int        `json:"updated_uid" gorm:"type:int"`
	UpdatedAt  time.Time  `json:"updated_at"`
	DeletedAt  *time.Time `json:"deleted_at"`
}
