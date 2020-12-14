package org.catty.inspectionlog;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.catty.photo.Photo;
import org.catty.photo.PhotoFileMapper;
import org.catty.photo.PhotoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class InspectionLogServiceImpl implements InspectionLogService {
	@Autowired
	private InspectionLogMapper inspectionLogMapper;
	
	@Autowired
	private PhotoMapper photoMapper;
	
	@Autowired
	private PhotoFileMapper photoFileMapper;
	//점검일지 등록
	@Override
	public boolean registerInspectionLog(InspectionLog inspectionLog, MultipartFile attach) {
		try { 
			
			
			int inspectionLogRow = inspectionLogMapper.insertInspectionLog(inspectionLog);
			
			if (inspectionLogRow > 0) {
				if (attach.getSize() > 0) {
					inspectionLog = inspectionLogMapper.selectInspectionLog(inspectionLog);
					
					if (inspectionLog != null) {
						Photo photo = photoFileMapper.downloadFile(attach, 'I');
						if (photo != null) {
							photo.setTypeNo(inspectionLog.getNo());
							
							int insertPhotoRow = photoMapper.insertPhoto(photo);
							if (insertPhotoRow > 0) {
								
								return true;
							} else {
								photoFileMapper.deleteFile(photo);
								photoMapper.deletePhoto(photo);
								
								return false;
							}
						}
					}
				}
				
				return true;
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		//점검일지 등록
		//사진을 등록해야됨
		//파라미터로 사진 가져와야하나?
		return false;
	}

	//점검일지 목록 조회
	@Override
	public List<InspectionLog> getInspectionLogList(String term) {
		//점검일지 
		List<InspectionLog> inspectionLogList = null;
		try {
			inspectionLogList = inspectionLogMapper.selectInspectionLogList(term);	//검색어 (시설물 명)로 검색한 결과 가져옴
		} catch (Exception e) {
			e.printStackTrace();
		}
		return inspectionLogList;
	}



	//점검일지 수정
	@Override
	public boolean editInspectionLog(InspectionLog inspectionLog, MultipartFile attach) {
		try {
			int updateRow = inspectionLogMapper.updateInspectionLog(inspectionLog);
			
			if (updateRow > 0) {
				if (attach.getSize() > 0) {
					System.out.println(attach.getOriginalFilename()+"/////////////////////////////////////////////////1");
					Photo photo = new Photo();
					photo.setType("I");
					photo.setTypeNo(inspectionLog.getNo());
					photo = photoMapper.selectPhoto(photo);
					
					int insertPhotoRow = 0;
					if (photo == null) {
						System.out.println(attach.getOriginalFilename()+"/////////////////////////////////////////////////2");
						photo = photoFileMapper.downloadFile(attach, 'I');
						
						if (photo != null) {
							System.out.println(attach.getOriginalFilename()+"/////////////////////////////////////////////////3");
							photo.setTypeNo(inspectionLog.getNo());
							insertPhotoRow = photoMapper.insertPhoto(photo);
						}
					} else {
						photo = photoFileMapper.updateFile(photo, attach);
						
						if (photo != null) {
							insertPhotoRow = photoMapper.updatePhoto(photo);
						}
					}
						
					if (insertPhotoRow > 0) {
						
						return true;
					} else {
						photoFileMapper.deleteFile(photo);
						photoMapper.deletePhoto(photo);
						
						return false;
					}
				}
				
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	//점검일지 삭제
	@Override
	public boolean deleteInspectionLog(InspectionLog inspectionLog) {
		try {
			inspectionLog = inspectionLogMapper.selectInspectionLog(inspectionLog);
			
			if (inspectionLog != null) {
				//존재한다면 삭제
				Photo photo = new Photo();
				photo.setType("I");
				photo.setTypeNo(inspectionLog.getNo());
				photo = photoMapper.selectPhoto(photo);
				
				if (photo != null) {
					// 관찰일지 사진 정보 삭제
					photoMapper.deletePhoto(photo);
					//관찰일지 사진 파일 삭제
					photoFileMapper.deleteFile(photo);
				}

				int deleteRow = inspectionLogMapper.deleteInspectionLog(inspectionLog);
				if (deleteRow > 0) {
					
					return true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//점검일지 조회
	@Override
	public InspectionLog getInspectionLog(InspectionLog inspectionLog) {
		try {
			return inspectionLogMapper.selectInspectionLog(inspectionLog);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return inspectionLog;
	}	
}
