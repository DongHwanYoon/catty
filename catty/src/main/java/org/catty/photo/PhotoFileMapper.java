package org.catty.photo;

import java.io.File;
import java.nio.file.Files;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

@Repository
public class PhotoFileMapper {
	@Value("${photo.path.cat}")
	private String catPath;
	@Value("${photo.path.obsLog}")
	private String obsLogPath;
	@Value("${photo.path.insLog}")
	private String insLogPath;
	
	//파일 가져오기
	public byte[] getFile(Photo photo) {
		try {
			if (photo != null) {
				File file =  new File(photo.getPath() + File.separator + photo.getPhysicalName());
				
				return Files.readAllBytes(file.toPath());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//사진 파일 저장
	public Photo downloadFile(MultipartFile attach, char type) {
		try {
			if (attach.getSize() > 0) {
				//사진의 형식이 올바른지?
//				String prefix = attach.getOriginalFilename();
//				String subfix = prefix.substring(prefix.length() - 3, prefix.length());
//				
//				if (subfix.equals("jpg") || subfix.equals("png") || subfix.equals("jpeg")) {}
				
				Photo photo = new Photo();
				photo.setLogicalName(attach.getOriginalFilename());
				photo.setPhysicalName(UUID.randomUUID().toString() + "_" + attach.getOriginalFilename());
				
				if (type == 'C') {
					photo.setPath(catPath);
					photo.setType("C");
					
					attach.transferTo(new File(catPath + File.separator + photo.getPhysicalName()));
				} else if (type == 'O') {
					photo.setPath(obsLogPath);
					photo.setType("O");
					
					attach.transferTo(new File(obsLogPath + File.separator + photo.getPhysicalName()));
				} else if (type == 'O') {
					photo.setPath(insLogPath);
					photo.setType("I");
					
					attach.transferTo(new File(insLogPath + File.separator + photo.getPhysicalName()));
				} else {
					
					return null;
				}
				
				return photo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//사진 파일 수정
	public Photo updateFile(Photo photo, MultipartFile attach) {
		try {
			if (photo != null || attach.getSize() > 0) {
				boolean result = deleteFile(photo);
				
				if (result) {
					photo.setLogicalName(attach.getOriginalFilename());
					photo.setPhysicalName(UUID.randomUUID().toString() + "_" + attach.getOriginalFilename());
					
					attach.transferTo(new File(photo.getPath() + File.separator + photo.getPhysicalName()));
					
					return photo;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//사진 파일 삭제
	public boolean deleteFile(Photo photo) {
		
		if (photo != null) {
			
			return new File(photo.getPath() + File.separator + photo.getPhysicalName()).delete();
		}
			
		return false;
	}
}
