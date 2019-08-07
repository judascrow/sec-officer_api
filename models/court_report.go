package models

import (
	"time"
)

// CourtReport Models
type CourtReport struct {
	ID                    uint                    `json:"id" gorm:"primary_key"`
	CourtID               int                     `json:"court_id" gorm:"type:int;unique_index:idx_1;not null"`
	Year                string                     	`json:"year" gorm:"type:varchar(4);unique_index:idx_1;not null"`
	Month                string                     `json:"month" gorm:"type:varchar(2);unique_index:idx_1;not null"`
	Work7Day              int                     `json:"work_7day" gorm:"type:int"`
	Work6Day              int                     `json:"work_6day" gorm:"type:int"`
	TotalShuffle          int                     `json:"total_shuffle" gorm:"type:int"`
	TotalShuffleExcept    int                     `json:"total_shuffle_except" gorm:"type:int"`
	TotalShuffleAbsence   int                     `json:"total_shuffle_absence" gorm:"type:int"`
	ReporterName          string                  `json:"reporter_name" gorm:"type:varchar(255)"`
	ReporterPosition      string                  `json:"reporter_position" gorm:"type:varchar(255)"`
	InspectorName         string                  `json:"inspector_name" gorm:"type:varchar(255)"`
	InspectorPosition     string                  `json:"inspector_position" gorm:"type:varchar(255)"`
	Status                string                  `json:"status" gorm:"type:varchar(10);DEFAULT:'W'"`
	CreatedUID            int                     `json:"created_uid" gorm:"type:int"`
	CreatedAt             time.Time               `json:"created_at"`
	UpdatedUID            int                     `json:"updated_uid" gorm:"type:int"`
	UpdatedAt             time.Time               `json:"updated_at"`
	CourtReportSecPersons []CourtReportSecPerson `json:"court_report_sec_persons" gorm:"foreignkey:court_report_id"`
}

// CourtReportSecPersons Models
type CourtReportSecPerson struct {
	ID                 uint       `json:"id" gorm:"primary_key"`
	CourtReportID      int        `json:"court_report_id" gorm:"type:int;unique_index:idx_1;not null"`
	SecPersonsID       int        `json:"sec_persons_id" gorm:"type:int;unique_index:idx_1;not null"`
	SecPersons         SecPersons `json:"sec_persons"`
	Type               int        `json:"type" gorm:"type:int"`
	DayMonth           int        `json:"day_month" gorm:"type:int"`
	DayMonthWork       int        `json:"day_month_work" gorm:"type:int"`
	Shuffle            int        `json:"shuffle" gorm:"type:int"`
	ShuffleDateName    string     `json:"shuffle_date_name" gorm:"type:varchar(500)"`
	ShuffleAbsence     int        `json:"shuffle_Absence" gorm:"type:int"`
	ShuffleAbsenceDate string  `json:"shuffle_Absence_date" `
	HNot12             int        `json:"h_not_12" gorm:"type:int"`
	HNot12DateH        string     `json:"h_not_12_date_h" gorm:"type:varchar(500)"`
	Remark             string     `json:"remark" gorm:"type:varchar(500)"`
	CreatedAt          time.Time  `json:"created_at"`
	UpdatedAt          time.Time  `json:"updated_at"`
}
