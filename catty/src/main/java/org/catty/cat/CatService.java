package org.catty.cat;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface CatService {
	public boolean registerCat(Cat cat, MultipartFile attach);
	public List<Cat> getCatList(String term, int sort);
	public Cat getCat(Cat cat);
	public boolean editCat(Cat cat, MultipartFile attach);
	public boolean deleteCat(Cat cat);
	public boolean saveAccessRecord(Map<String, Object> object);
	public List<AccessRecord> getAccessRecordList(Cat cat);
	public List<AccessRecord> getAccessRecordForTime(Cat cat);
	public AccessRecord getAccessRecord(Cat cat);
	public boolean setTagId(Cat cat);
}
