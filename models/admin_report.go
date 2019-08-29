package models

// AdminReport Models
type AdminReport struct {
	ID               uint   `json:"id"`
	CourtID          int    `json:"court_id"`
	CourtName        string `json:"court_name"`
	DepartmentName   string `json:"department_name"`
	Year             int    `json:"year"`
	Month            int    `json:"month"`
	Type7DayBoss     int    `json:"type_7day_boss"`
	Type7DayOperator int    `json:"type_7day_operator"`
	Type6DayBoss     int    `json:"type_6day_boss"`
	Type6DayOperator int    `json:"type_6day_operator"`
	Total            int    `json:"total"`
	ShuffleAbsence   int    `json:"shuffle_absence"`
	ShuffleExcept    int    `json:"shuffle_except" `
	HNot12           int    `json:"h_not_12" `
	DocNo            string `json:"doc_no" `
	FilePath         string `json:"file_path" `
}

// AdminReportChild Models
type AdminReportChild struct {
	Type7DayBoss     int `json:"type_7day_boss" gorm:"Column:type_7day_boss"`
	Type7DayOperator int `json:"type_7day_operator"  gorm:"Column:type_7day_operator"`
	Type6DayBoss     int `json:"type_6day_boss" gorm:"Column:type_6day_boss"`
	Type6DayOperator int `json:"type_6day_operator"  gorm:"Column:type_6day_operator"`
	Total            int `json:"total" gorm:"Column:total"`
	HNot12           int `json:"h_not_12"  gorm:"Column:h_not_12" `
}
