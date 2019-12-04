package kh.jomalone.DTO;

public class ProductDTO {
	private String productCode;
	private String category;
	private String productName;
	private int price;
	private int quantity;
	private String description;
	private int spring;
	private int summer;
	private int fall;
	private int winter;
	private String content;
	private String ingredients;
	
	public ProductDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ProductDTO(String productName, int price, int quantity, String description, int spring, int summer, int fall,
			int winter) {
		super();
		this.productName = productName;
		this.price = price;
		this.quantity = quantity;
		this.description = description;
		this.spring = spring;
		this.summer = summer;
		this.fall = fall;
		this.winter = winter;
	}

	public ProductDTO(String productCode, String category, String productName, int price, int quantity,
			String description, int spring, int summer, int fall, int winter) {
		super();
		this.productCode = productCode;
		this.category = category;
		this.productName = productName;
		this.price = price;
		this.quantity = quantity;
		this.description = description;
		this.spring = spring;
		this.summer = summer;
		this.fall = fall;
		this.winter = winter;
	}
	
	public ProductDTO(String productCode, String productName, int price) {
		super();
		this.productCode = productCode;
		this.productName = productName;
		this.price = price;
	}

	public ProductDTO(String productCode, String category, String productName, int price, int quantity,
			String description, int spring, int summer, int fall, int winter, String content, String ingredients) {
		super();
		this.productCode = productCode;
		this.category = category;
		this.productName = productName;
		this.price = price;
		this.quantity = quantity;
		this.description = description;
		this.spring = spring;
		this.summer = summer;
		this.fall = fall;
		this.winter = winter;
		this.content = content;
		this.ingredients = ingredients;
	}

	/**
	 * @return the productCode
	 */
	public String getProductCode() {
		return productCode;
	}
	/**
	 * @param productCode the productCode to set
	 */
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	/**
	 * @return the category
	 */
	public String getCategory() {
		return category;
	}
	/**
	 * @param category the category to set
	 */
	public void setCategory(String category) {
		this.category = category;
	}
	/**
	 * @return the productName
	 */
	public String getProductName() {
		return productName;
	}
	/**
	 * @param productName the productName to set
	 */
	public void setProductName(String productName) {
		this.productName = productName;
	}
	/**
	 * @return the price
	 */
	public int getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(int price) {
		this.price = price;
	}
	/**
	 * @return the quantity
	 */
	public int getQuantity() {
		return quantity;
	}
	/**
	 * @param quantity the quantity to set
	 */
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return the spring
	 */
	public int getSpring() {
		return spring;
	}
	/**
	 * @param spring the spring to set
	 */
	public void setSpring(int spring) {
		this.spring = spring;
	}
	/**
	 * @return the summer
	 */
	public int getSummer() {
		return summer;
	}
	/**
	 * @param summer the summer to set
	 */
	public void setSummer(int summer) {
		this.summer = summer;
	}
	/**
	 * @return the fall
	 */
	public int getFall() {
		return fall;
	}
	/**
	 * @param fall the fall to set
	 */
	public void setFall(int fall) {
		this.fall = fall;
	}
	/**
	 * @return the winter
	 */
	public int getWinter() {
		return winter;
	}
	/**
	 * @param winter the winter to set
	 */
	public void setWinter(int winter) {
		this.winter = winter;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIngredients() {
		return ingredients;
	}

	public void setIngredients(String ingredients) {
		this.ingredients = ingredients;
	}
	
}