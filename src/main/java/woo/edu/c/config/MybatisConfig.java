package woo.edu.c.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan("mappers")
public class MybatisConfig {

}
