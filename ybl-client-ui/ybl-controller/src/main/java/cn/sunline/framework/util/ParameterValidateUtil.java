package cn.sunline.framework.util;

import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

public class ParameterValidateUtil {
	
	public static String validate(Object object) {
		ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
		Validator validator = factory.getValidator();
		Set<ConstraintViolation<Object>> violations = validator.validate(object);
		if (violations.size() > 0) {
			for (ConstraintViolation<Object> violation : violations) {
				//System.out.println(violation.getPropertyPath().toString() + " " + violation.getConstraintDescriptor().getAnnotation().annotationType().getName());
				if("javax.validation.constraints.Null".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.NotNull".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.AssertTrue".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.AssertFalse".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.Min".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.Max".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.DecimalMin".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.DecimalMax".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.Size".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.Digits".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.Past".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.Future".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"javax.validation.constraints.Pattern".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"org.hibernate.validator.constraints.Email".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"org.hibernate.validator.constraints.Length".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"org.hibernate.validator.constraints.NotEmpty".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())||
						"org.hibernate.validator.constraints.Range".equals(violation.getConstraintDescriptor().getAnnotation().annotationType().getName())){
				}
				return violation.getMessage();
			}
		}
		return "";
	}

}
