package org.catty.photo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PhotoServiceImpl implements PhotoService {
	@Autowired
	private PhotoMapper photoMapper;
	@Autowired
	private PhotoFileMapper photoFileMapper;
	
	public byte[] getPhoto(Photo photo) {
		try {
			photo = photoMapper.selectPhoto(photo);
			if (photo != null) {
				byte[] file =  photoFileMapper.getFile(photo);
				
				if (file != null) {
					
					return file;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
