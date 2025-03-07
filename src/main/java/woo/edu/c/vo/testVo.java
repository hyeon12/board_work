package woo.edu.c.vo;

public class testVo {

	private String deptNo;
	private String dName;
	private String loc;

	
	public String getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}
	public String getDnName() {
		return dName;
	}
	public void setDnName(String dnName) {
		this.dName = dnName;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	
	@Override
	public String toString() {
		return "BoardVo [deptNo=" + deptNo + ", dName=" + dName + ", loc=" + loc + "]";
	}
	
}
