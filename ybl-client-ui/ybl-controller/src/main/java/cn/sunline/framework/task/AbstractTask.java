package cn.sunline.framework.task;

import java.net.InetAddress;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;

public abstract class AbstractTask extends SunlineMethodInvokingJobDetailFactoryBean implements Task {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3811782293501750240L;
	
	protected final Logger log = LoggerFactory.getLogger(getClass());
	
	protected abstract void task();
	
	@Override
	public final void run() {
		// 校验是否符合运行条件
		if(!validate()) {
			return;
		}
		long begin = System.currentTimeMillis();
		log.info("begin execution task = {}", getClass().getName());
		try {
			task();
		} catch(Exception e) {
			log.error("task = " + getClass().getName() + " execution exception：", e);
		}
		log.info("end execution task = {}，time：{}s", getClass().getName(), (System.currentTimeMillis() - begin)/1000);
	}
	
	/**
	 * 
	 * 正常返回则表示验证通过，抛出异常表示验证不通过
	 * 
	 */
	private final boolean validate() {
		try {
			// 获取当前机器ip
			InetAddress localhost = InetAddress.getLocalHost();
			InetAddress[] addrs = InetAddress.getAllByName(localhost.getHostName());
			// 计划任务允许运营ip
			String targetHost = SchedulePropCache.getInstance().getByKey("schedule.run.target.host");
			Assert.hasText(targetHost, "schedule.run.target.host must be configure in schedule.properties.");
			// 如果配置为本机运行，则校验通过
			if(targetHost.equalsIgnoreCase("127.0.0.1") || targetHost.equalsIgnoreCase("localhost")) {
				return true;
			}
			for(InetAddress addr : addrs) {
				// 验证通过则直接返回
				if(targetHost.equalsIgnoreCase(addr.getHostAddress())) {
					return true;
				}
			}
			// 验证不通过抛出异常
			log.warn("configure schedule.run.target.host not this host. schedule.run.target.host is {}", targetHost);
			return false;
		} catch(Exception e) {
			throw new RuntimeException("validate host exception：", e);
		}
	}
}
