package cn.sunline.framework.task;

/**
 * 
 * 计划任务使用说明：
 * 1.所有计划人物类必须继承AbstractTask，最终运行的方法为：run，
 * 配置在spring里面的运行方法统一配置：run即可（参考已有配置）
 * 2.计划任务允许运行的ip见schedule.properties的schedule.run.target.host
 * 3.编写计划任务参考DemoTask.java，业务只需要实现task方法即可
 * 4.建议所有异常往上抛，父类已经统一做处理
 * 
 * @author andyLee
 * @createDate 2017-04-25 17:00:00
 */
public class DemoTask extends AbstractTask {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4622539187929081302L;

	@Override
	protected void task() {
		// doSomething
		System.out.println("===doSomething===");
	}
}
