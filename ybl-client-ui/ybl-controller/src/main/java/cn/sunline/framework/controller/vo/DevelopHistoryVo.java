package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class DevelopHistoryVo extends AbstractEntity{

	/**
	 * 发展历程实体类
	 */
	private static final long serialVersionUID = -395739434156974971L;
	//标题
		private String title;
		//内容
		private String content;
		@JSONField(name="title_")
		public String getTitle() {
			return title;
		}
		@JSONField(name="title_")
		public void setTitle(String title) {
			this.title = title;
		}
		@JSONField(name="content_")
		public String getContent() {
			return content;
		}
		@JSONField(name="content_")
		public void setContent(String content) {
			this.content = content;
		}
		
	}
