package cn.sunline.framework.controller.vo.v4.factor.enums;

/**
 * 底层资产使用状态枚举
 * @author pc
 *
 */
public enum E_V4_IS_USE {
	
	USED("已使用",1),
	UNUSE("未使用",2),
	USING("占用",3);
	
	
	String name;
	int status;
	
	E_V4_IS_USE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_IS_USE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_IS_USE get(int optype) {
		for (E_V4_IS_USE op : values()) {
			if (op.getStatus() == optype) {
				return op;
			}
		}
		return null;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
  