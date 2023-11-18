package kr.ac.kopo.itnara.model;

public class Search {
	private Long category1Code;
	private int row = 10;
	private String order = "DESC";
	private String search;

	public Long getCategory1Code() {
		return category1Code;
	}

	public void setCategory1Code(Long category1Code) {
		this.category1Code = category1Code;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getSearch() {
		return search;
	}

	@Override
	public String toString() {
		return "Search [category1Code=" + category1Code + ", row=" + row + ", order=" + order + ", search=" + search
				+ "]";
	}

	public void setSearch(String search) {
		this.search = search;
	}

    public boolean isSearchNotEmpty() {
        return search != null && !search.isEmpty();
    }

}
