package models

import (
	"time"
)

// CourtReport Models
type CourtReport struct {
	ID                    uint                   `json:"id" gorm:"primary_key"`
	CourtID               int                    `json:"court_id" gorm:"type:int;unique_index:idx_1;not null"`
	Court                 Court                  `json:"court" gorm:"association_foreignkey:CourtID;foreignkey:ID"`
	Year                  string                 `json:"year" gorm:"type:varchar(4);unique_index:idx_1;not null"`
	Month                 string                 `json:"month" gorm:"type:varchar(2);unique_index:idx_1;not null"`
	Work7Day              int                    `json:"work_7day" gorm:"type:int"`
	Work6Day              int                    `json:"work_6day" gorm:"type:int"`
	TotalShuffle          int                    `json:"total_shuffle" gorm:"type:int"`
	TotalShuffleExcept    int                    `json:"total_shuffle_except" gorm:"type:int"`
	TotalShuffleAbsence   int                    `json:"total_shuffle_absence" gorm:"type:int"`
	ReporterName          string                 `json:"reporter_name" gorm:"type:varchar(255)"`
	ReporterPosition      string                 `json:"reporter_position" gorm:"type:varchar(255)"`
	InspectorName         string                 `json:"inspector_name" gorm:"type:varchar(255)"`
	InspectorPosition     string                 `json:"inspector_position" gorm:"type:varchar(255)"`
	Status                string                 `json:"status" gorm:"type:varchar(10);DEFAULT:'W'"`
	FilePath              string                 `json:"file_path" gorm:"type:varchar(255)"`
	DocNo                 string                 `json:"doc_no" gorm:"type:varchar(255)"`
	CreatedUID            int                    `json:"created_uid" gorm:"type:int"`
	CreatedAt             time.Time              `json:"created_at"`
	UpdatedUID            int                    `json:"updated_uid" gorm:"type:int"`
	UpdatedAt             time.Time              `json:"updated_at"`
	CourtReportSecPersons []CourtReportSecPerson `json:"court_report_sec_persons" gorm:"foreignkey:court_report_id"`
}

// CourtReportSecPerson Models
type CourtReportSecPerson struct {
	ID            uint `json:"id" gorm:"primary_key"`
	CourtReportID int  `json:"court_report_id" gorm:"type:int;not null"`
	// SecPersonsID       int        `json:"sec_persons_id" gorm:"type:int;unique_index:idx_1;not null"`
	// SecPersons         SecPersons `json:"sec_persons"`
	SecPersonName      string    `json:"sec_person_name"`
	Type               int       `json:"type" gorm:"type:int"`
	Role               int       `json:"role" gorm:"type:int;DEFAULT:2"`
	DayMonth           int       `json:"day_month" gorm:"type:int"`
	DayMonthWork       int       `json:"day_month_work" gorm:"type:int"`
	Shuffle            int       `json:"shuffle" gorm:"type:int"`
	ShuffleExcept      int       `json:"shuffle_except" gorm:"type:int"`
	ShuffleDateName    string    `json:"shuffle_date_name" gorm:"type:varchar(500)"`
	ShuffleAbsence     int       `json:"shuffle_Absence" gorm:"type:int"`
	ShuffleAbsenceDate string    `json:"shuffle_Absence_date" gorm:"type:varchar(500)" `
	HNot12             int       `json:"h_not_12" gorm:"type:int"`
	HNot12DateH        string    `json:"h_not_12_date_h" gorm:"type:varchar(500)"`
	Remark             string    `json:"remark" gorm:"type:varchar(500)"`
	CreatedAt          time.Time `json:"created_at"`
	UpdatedAt          time.Time `json:"updated_at"`
}
