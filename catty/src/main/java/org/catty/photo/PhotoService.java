package org.catty.photo;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;

public interface PhotoService {
	public byte[] getPhoto(Photo photo);
}
