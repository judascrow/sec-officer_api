package models

import (
	"time"
)

// SecPersons Model
type SecPersons struct {
	ID         uint      `json:"id" gorm:"primary_key"`
	Nid        string    `json:"nid" gorm:"type:varchar(13)"`
	FullName   string    `json:"full_name" gorm:"type:varchar(500)"`
	CourtID    int       `json:"court_id" gorm:"type:int"`
	Status     string    `json:"status" gorm:"type:varchar(10);DEFAULT:'A'"`
	CreatedUid int       `json:"created_uid" gorm:"type:int"`
	CreatedAt  time.Time `json:"created_at"`
	UpdatedUid int       `json:"updated_uid" gorm:"type:int"`
	UpdatedAt  time.Time `json:"updated_at"`
}
