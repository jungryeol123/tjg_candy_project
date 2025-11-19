package com.tjg_project.candy;

import java.io.IOException;
import java.util.logging.*;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class
CandyApplication {

	public static void main(String[] args) throws IOException {
		SpringApplication.run(CandyApplication.class, args);
        Logger rootLogger = Logger.getLogger("");
        FileHandler fh = new FileHandler("app.log", true);
        fh.setFormatter(new SimpleFormatter());
        rootLogger.addHandler(fh);
	}

}
