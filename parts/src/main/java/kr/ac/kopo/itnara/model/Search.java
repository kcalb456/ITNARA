package kr.ac.kopo.itnara.model;

public class Search {
	private String name;
	private int row = 10;
	private String order = "DESC";
	private String search;
	private  Long userId;
	private int soldCheck = 99;

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
		return "Search [name=" + name + ", row=" + row + ", order=" + order + ", search=" + search + "]";
	}

	public void setSearch(String search) {
		this.search = search;
	}

    public boolean isSearchNotEmpty() {
        return search != null && !search.isEmpty();
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public int getSoldCheck() {
		return soldCheck;
	}

	public void setSoldCheck(int soldCheck) {
		this.soldCheck = soldCheck;
	}


}
