package cn.sunline.framework.controller.vo.v2;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.i18n.I18NUtils;

import edu.emory.mathcs.backport.java.util.Collections;

//首页待审核事项
public class TodoListVo implements Comparable<TodoListVo>{
	
	//功能
	private String function;
	
	//关键内容
	private String summary;
	
	//操作日期
	private String lastUpdateTime;
	
	//操作url
	private String handleUrl;
	
	//待处理列表
	private List<TodoListVo> todoListVos = new ArrayList<>();
	
	
	
	//将待审核的列表放入待处理列表中
	public void setAuditTodoList(List<Map> auditList,String functionName,String uri){
		
		if(auditList!=null){
			for(Map data:auditList){
				
				String _function = data.get("supplier_enterprise_name")!=null?data.get("supplier_enterprise_name").toString()+ ","+functionName : "";
				String  _updateTime = data.get("created_time") !=null?stampToDate(data.get("created_time").toString()) : "";
				
				setTodoVo(I18NUtils.getText("sys.v2.client.finance.audit")                                                      
						,_function    
						,_updateTime
						,uri+"?id="+data.get("id_").toString());
			}
		}
	}
	
	
	

	//将待待放款放入待处理列表中
	public void setGenerateDisburseTodoList(List<V2GenerateDisbursementBatchVo> disbursementBatchVos){
		
		if(disbursementBatchVos!=null){
			for(V2GenerateDisbursementBatchVo data:disbursementBatchVos){
				
				String _function = data.getEnterpriseName()+"," + I18NUtils.getText("sys.v2.client.generate.payment.lot");
				String  _updateTime = DateUtils.toString(data.getLastUpdateTime()) ;
				String _handleUrl = "/v2disbursementController/queryGenerateBatchList.htm";
				
				setTodoVo(I18NUtils.getText("sys.v2.client.Loan.outAccount")                                                     
						,_function    
						,_updateTime
						,_handleUrl
						);
			}
		}
	}
	
	//将待待放款放入待处理列表中
	public void setDisburseTodoList(List<V2DisbursementBatchVo> disbursementBatchVos){
		
		if(disbursementBatchVos!=null){
			for(V2DisbursementBatchVo data:disbursementBatchVos){
				
				String _function = data.getSupplierEnterpriseName()+","+ I18NUtils.getText("sys.v2.client.batch.tobepaid") ;
				String  _updateTime = DateUtils.toString(data.getLastUpdateTime()) ;
				String _handleUrl = "/v2disbursementController/getBalanceDetail.htm-"+data.getBatchNumber();
				
				setTodoVo(I18NUtils.getText("sys.v2.client.Loan.outAccount")                                                   
						,_function    
						,_updateTime
						,_handleUrl
						);
			}
		}
	}
	
	
	
	//待退款列表
	public void setReimburseTodoList(List<V2BalanceVo> balanceVo){
		
		if(balanceVo!=null){
			for(V2BalanceVo data:balanceVo){
				
				String _function = data.getSupplierEnterpriseName()+"," + I18NUtils.getText("sys.v2.client.to.Refund");
				String  _updateTime = DateUtils.toString(data.getReimburseTime()) ;
				String _handleUrl = "/v2BalanceController/reimbursementEdit.htm-"+data.getId();
				
				setTodoVo(I18NUtils.getText("sys.v2.client.refund.process")                                                  
						,_function    
						,_updateTime
						,_handleUrl
						);
			}
		}
	}
	
	
	
	
	
	private void setTodoVo(String function,String summary,String lastUpdateTime,String handleUrl){
		
		TodoListVo todoVo = new TodoListVo();
		todoVo.setFunction(function);
		todoVo.setSummary(summary);
		todoVo.setLastUpdateTime(lastUpdateTime);
		todoVo.setHandleUrl(handleUrl);
		
		this.todoListVos.add(todoVo);
		
	}
	
	public List<TodoListVo> getTodoList(){
		
		//对列表进行排序
		Collections.sort(todoListVos);
		
		return this.todoListVos;
	}
	
	
	
	public String getHandleUrl() {
		return handleUrl;
	}

	public void setHandleUrl(String handleUrl) {
		this.handleUrl = handleUrl;
	}

	public String getFunction() {
		return function;
	}

	
	public void setFunction(String function) {
		this.function = function;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getLastUpdateTime() {
		return lastUpdateTime;
	}

	public void setLastUpdateTime(String lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
	
	
	/* 
     * 将时间戳转换为时间
     */
    public static String stampToDate(String s){
        String res;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        long lt = new Long(s);
        Date date = new Date(lt);
        res = simpleDateFormat.format(date);
        return res;
    }


	//按照操作日期的降序排序
	@Override
	public int compareTo(TodoListVo todoListVo) {

		return  0 - this.lastUpdateTime.compareTo(todoListVo.lastUpdateTime);
	}


	

}
