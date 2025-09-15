package board.dto;

import board.controller.Pagination;

public class SearchDTO {
	private int page;
	private int recordSize;
	private int pageSize;
	private String keyword;
	private String searchType;
	private Pagination pagination;
	
	public SearchDTO() {
		this.page = 1;
		this.recordSize = 10;
		this.pageSize = 10;
	}
	
	public int getOffset() {
		return (page-1)*recordSize;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRecordSize() {
		return recordSize;
	}

	public void setRecordSize(int recordSize) {
		this.recordSize = recordSize;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public void setPagination(Pagination pagination) {
	    this.pagination = pagination;
	}
	public Pagination getPagination() {
	    return pagination;
	}
	
}
