package board.controller;

import board.dto.SearchDTO;

public class Pagination {
    private int totalRecordCount;   // 전체 게시글 수
    private int totalPageCount;     // 전체 페이지 수
    private int startPage;          // 시작 페이지 번호
    private int endPage;            // 끝 페이지 번호
    private boolean hasPrev;        // 이전 버튼 활성화 여부
    private boolean hasNext;        // 다음 버튼 활성화 여부

    public int getTotalRecordCount() {
		return totalRecordCount;
	}

	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isHasPrev() {
		return hasPrev;
	}

	public void setHasPrev(boolean hasPrev) {
		this.hasPrev = hasPrev;
	}

	public boolean isHasNext() {
		return hasNext;
	}

	public void setHasNext(boolean hasNext) {
		this.hasNext = hasNext;
	}

	public Pagination(int totalRecordCount, SearchDTO params) {
        this.totalRecordCount = totalRecordCount;

        // 전체 페이지 수 계산
        this.totalPageCount = (int)Math.ceil((double) totalRecordCount / params.getRecordSize());

        // 현재 페이지 블록 계산
        int currentBlock = (int)Math.ceil((double) params.getPage() / params.getPageSize());
        this.startPage = (currentBlock - 1) * params.getPageSize() + 1;
        this.endPage = startPage + params.getPageSize() - 1;

        if (endPage > totalPageCount) {
            endPage = totalPageCount;
        }

        this.hasPrev = startPage > 1;
        this.hasNext = endPage < totalPageCount;
    }

    // getter/setter 생략
}