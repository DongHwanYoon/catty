package org.catty.observationlog;

import java.util.List;

import org.catty.photo.Photo;
import org.catty.photo.PhotoFileMapper;
import org.catty.photo.PhotoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ObservationLogServiceImpl implements ObservationLogService {
	@Autowired
	private ObservationLogMapper observationLogMapper;
	@Autowired
	private PhotoMapper photoMapper;
	@Autowired
	private PhotoFileMapper photoFileMapper;
	
	@Override
	@Transactional
	public boolean registerObservationLog(ObservationLog observationLog, MultipartFile attach) {
		try {
			//1. 관찰일지 등록
			int insertObsLogRow = observationLogMapper.insertObservationLog(observationLog);	
			
			if (insertObsLogRow > 0) {
				if (attach.getSize() > 0) {
					observationLog = observationLogMapper.selectObservationLog(observationLog);
					
					if (observationLog != null) {
						//2. 관찰일지 사진 파일 저장
						Photo photo = photoFileMapper.downloadFile(attach, 'O');
						if (photo != null) {
							photo.setTypeNo(observationLog.getNo());
							
							//3. 관찰일지 사진 정보 등록
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	@Override
	public List<ObservationLog> getObservationLogList(ObservationLog observationLog) {
		try {
			//1. 관찰일지 리스트를 조회한다.
			return observationLogMapper.selectObservationLogList(observationLog);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

	@Override
	public ObservationLog getObservationLog(ObservationLog observationLog) {
		try {
			return observationLogMapper.selectObservationLog(observationLog);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	@Transactional
	public boolean editObservationLog(ObservationLog observationLog, MultipartFile attach) {
		try {
			int updateRow = observationLogMapper.updateObservationLog(observationLog);
			
			if (updateRow > 0) {
				if (attach.getSize() > 0) {
					//3. 관찰일지 사진 수정
					Photo photo = new Photo();
					photo.setType("O");
					photo.setTypeNo(observationLog.getNo());
					photo = photoMapper.selectPhoto(photo);
					
					int insertPhotoRow = 0;
					if (photo == null) {
						photo = photoFileMapper.downloadFile(attach, 'O');
						
						if (photo != null) {
							// 관찰일지 사진 정보 등록
							photo.setTypeNo(observationLog.getNo());
							insertPhotoRow = photoMapper.insertPhoto(photo);
						}
					} else {
						photo = photoFileMapper.updateFile(photo, attach);
						
						if (photo != null) {
							// 관찰일지 사진 정보 수정
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

	@Override
	@Transactional
	public boolean deleteObservationLog(ObservationLog observationLog) {
		try {
			observationLog = observationLogMapper.selectObservationLog(observationLog);
			
			if (observationLog != null) {
				//존재한다면 삭제
				Photo photo = new Photo();
				photo.setType("O");
				photo.setTypeNo(observationLog.getNo());
				photo = photoMapper.selectPhoto(photo);
				
				if (photo != null) {
					// 관찰일지 사진 정보 삭제
					photoMapper.deletePhoto(photo);
					//관찰일지 사진 파일 삭제
					photoFileMapper.deleteFile(photo);
				}

				int deleteRow = observationLogMapper.deleteObservationLog(observationLog);
				if (deleteRow > 0) {
					
					return true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
}
