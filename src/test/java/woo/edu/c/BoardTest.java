package woo.edu.c;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.AnnotationConfigWebContextLoader;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations={
//		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
//		"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@WebAppConfiguration
public class BoardTest {

	@Test
	public void test() {
		System.out.println("Å×½ºÆ®");
	}

}
