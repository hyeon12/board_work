package woo.edu.c.validator;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import woo.edu.c.controller.BoardForm;

@Component
public class BoardValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return clazz.isAssignableFrom(BoardForm.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		if (errors.hasErrors()) {
			return;
		}
		
		BoardForm form = (BoardForm) target;
		
		String mode = form.getMode();
		Long bno = form.getBno();
		if (StringUtils.hasText(mode) && mode.equals("edit") && (bno == null || bno < 1L)) {
			errors.reject("BadRequest");
		}
		
	}
}
