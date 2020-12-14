package org.catty.photo;

import java.io.File;
import java.nio.file.Files;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PhotoController {
	@Autowired
	private PhotoServiceImpl photoService;
	
	@GetMapping("/photo/cat/{no}")
	public void catView(@PathVariable int no, HttpServletResponse response) {
		try {
			Photo photo = new Photo();
			photo.setType("C");
			photo.setTypeNo(no);
			
			byte[] file = this.photoService.getPhoto(photo);
			if (file != null) {
				response.setContentType("image/jpeg");
				response.getOutputStream().write(file);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/photo/obslog/{no}")
	public void obsLogView(@PathVariable int no, HttpServletResponse response) {
		try {
			Photo photo = new Photo();
			photo.setType("O");
			photo.setTypeNo(no);
			
			byte[] file = this.photoService.getPhoto(photo);
			if (file != null) {
				response.setContentType("image/jpeg");
				response.getOutputStream().write(file);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/photo/inslog/{no}")
	public void insLogView(@PathVariable int no, HttpServletResponse response) {
		try {
			Photo photo = new Photo();
			photo.setType("I");
			photo.setTypeNo(no);
			
			byte[] file = this.photoService.getPhoto(photo);
			if (file != null) {
				response.setContentType("image/jpeg");
				response.getOutputStream().write(file);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
