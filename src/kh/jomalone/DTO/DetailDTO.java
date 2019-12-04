package kh.jomalone.DTO;

public class DetailDTO {
private int seq;
private String prod_code;
private String content;
private String ingredients;
public DetailDTO() {
	super();
	// TODO Auto-generated constructor stub
}
public DetailDTO(int seq, String prod_code, String content, String ingredients) {
	super();
	this.seq = seq;
	this.prod_code = prod_code;
	this.content = content;
	this.ingredients = ingredients;
}
/**
 * @return the seq
 */
public int getSeq() {
	return seq;
}
/**
 * @param seq the seq to set
 */
public void setSeq(int seq) {
	this.seq = seq;
}
/**
 * @return the prod_code
 */
public String getProd_code() {
	return prod_code;
}
/**
 * @param prod_code the prod_code to set
 */
public void setProd_code(String prod_code) {
	this.prod_code = prod_code;
}
/**
 * @return the content
 */
public String getContent() {
	return content;
}
/**
 * @param content the content to set
 */
public void setContent(String content) {
	this.content = content;
}
/**
 * @return the ingredients
 */
public String getIngredients() {
	return ingredients;
}
/**
 * @param ingredients the ingredients to set
 */
public void setIngredients(String ingredients) {
	this.ingredients = ingredients;
}


}
