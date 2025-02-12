package com.example.demo.collection;

public class Teacher extends People{
	private String manageType; //정교사, 기간제교사
	private String operateType; //담임교사, 일반교사
	
	public Teacher() {
		
	}
	
	public Teacher(
			 String name,
			 String age,
			 String sex,
			 String manageType,
			 String operateType
			) {
				this.setName(name);
				this.setAge(age);
				this.setSex(sex);
				
				this.manageType = manageType;
				this.operateType = operateType;
			}
	
	public String getManageType() {
		return manageType;
	}
	public void setManageType(String manageType) {
		this.manageType = manageType;
	}
	public String getOperateType() {
		return operateType;
	}
	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}

	@Override
	public String toString() {
		return "Teacher [manageType=" + manageType + ", operateType=" + operateType + "]"+super.toString();
	}
	
	
}
