package org.catty;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@MapperScan("org.catty")
@ComponentScan(basePackages= {"org.catty"})
public class CattyApplication {
	public static void main(String[] args) {
		SpringApplication.run(CattyApplication.class, args);
	}
}