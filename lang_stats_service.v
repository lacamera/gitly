module main

import vweb

const (
	test_lang_stats = [
		LangStat{
			name: 'V'
			pct: 989
			lines_count: 96657
			color: '#5d87bd'
		},
		LangStat{
			name: 'JavaScript'
			lines_count: 1131
			color: '#f1e05a'
			pct: 11
		},
	]
)

pub fn (l &LangStat) pct_html() vweb.RawHtml {
	x := f64(l.pct) / 10.0
	sloc := if l.lines_count < 1000 {
		l.lines_count.str()
	} else {
		(l.lines_count / 1000).str() + 'k'
	}

	return '<span>$x%</span> <span class=lang-stat-loc>$sloc loc</span>'
}

pub fn (mut app App) find_repo_lang_stats(repo_id int) []LangStat {
	return sql app.db {
		select from LangStat where repo_id == repo_id order by pct desc
	}
}