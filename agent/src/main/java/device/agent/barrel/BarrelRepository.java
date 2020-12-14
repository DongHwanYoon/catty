package device.agent.barrel;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.tinylog.Logger;

//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Repository
public class BarrelRepository implements InitializingBean {
	public static final MediaType MEDIA_TYPE_HTML = MediaType.get("tex/html; charset=utf-8");
	@Value("${device.hx.feed.first}")
	private String[] firstFeedConfig;
	@Value("${device.hx.feed.second}")
	private String[] secondFeedConfig;
	@Value("${device.hx.water.first}")
	private String[] firstWaterConfig;
	@Value("${device.hx.water.second}")
	private String[] secondWaterConfig;
	@Value("${device.hx.water.third}")
	private String[] thirdWaterConfig;
	
	private List<Hx711> feedBarrels;
	private List<Hx711> waterBarrels;
	
	@Override
	public void afterPropertiesSet() throws Exception {
		Logger.info("hx711 센서들 초기화 시작!!!");
		
		feedBarrels = new ArrayList<Hx711>();
		//FeedBarrel
		//first
		Hx711 temp = new Hx711(Integer.parseInt(firstFeedConfig[0]), Integer.parseInt(firstFeedConfig[1]), Integer.parseInt(firstFeedConfig[2]), Double.parseDouble(firstFeedConfig[3]));
		if (temp != null) {
			temp.measureAndSetTare();
			feedBarrels.add(temp);
			System.out.println("1번 사료통 값 : " + temp.readValue());
			Logger.info("1번 사료통 정보 : {} / {} / {} / {}", Integer.parseInt(firstFeedConfig[0]), Integer.parseInt(firstFeedConfig[1]), Integer.parseInt(firstFeedConfig[2]), Double.parseDouble(firstFeedConfig[3]));
		}
		
		//second
		temp = new Hx711(Integer.parseInt(secondFeedConfig[0]), Integer.parseInt(secondFeedConfig[1]), Integer.parseInt(secondFeedConfig[2]), Double.parseDouble(secondFeedConfig[3]));
		if (temp != null) {
			temp.measureAndSetTare();
			feedBarrels.add(temp);
			System.out.println("2번 사료통 값 : " + temp.readValue());
			Logger.info("2번 사료통 정보 : {} / {} / {} / {}", Integer.parseInt(secondFeedConfig[0]), Integer.parseInt(secondFeedConfig[1]), Integer.parseInt(secondFeedConfig[2]), Double.parseDouble(secondFeedConfig[3]));
		}
		//third
		temp = new Hx711(Integer.parseInt(secondFeedConfig[0]), Integer.parseInt(secondFeedConfig[1]), Integer.parseInt(secondFeedConfig[2]), Double.parseDouble(secondFeedConfig[3]));
		if (temp != null) {
			temp.measureAndSetTare();
			feedBarrels.add(temp);
			System.out.println("3번 사료통 값 : " + temp.readValue());
			Logger.info("3번 사료통 정보 : {} / {} / {} / {}", Integer.parseInt(secondFeedConfig[0]), Integer.parseInt(secondFeedConfig[1]), Integer.parseInt(secondFeedConfig[2]), Double.parseDouble(secondFeedConfig[3]));
		}
		
		waterBarrels = new ArrayList<Hx711>();
		
		//WaterBarrel
		//first
		temp = new Hx711(Integer.parseInt(firstWaterConfig[0]), Integer.parseInt(firstWaterConfig[1]), Integer.parseInt(firstWaterConfig[2]), Double.parseDouble(firstWaterConfig[3]));
		if (temp != null) {
			temp.measureAndSetTare();
			waterBarrels.add(temp);
			System.out.println("1번 물통 값 : " + temp.readValue());
			Logger.info("1번 물통 정보 : {} / {} / {} / {}", Integer.parseInt(firstWaterConfig[0]), Integer.parseInt(firstWaterConfig[1]), Integer.parseInt(firstWaterConfig[2]), Double.parseDouble(firstWaterConfig[3]));
		}
		
		temp = new Hx711(Integer.parseInt(firstWaterConfig[0]), Integer.parseInt(secondWaterConfig[1]), Integer.parseInt(secondWaterConfig[2]), Double.parseDouble(secondWaterConfig[3]));
		if (temp != null) {
			temp.measureAndSetTare();
			waterBarrels.add(temp);
			System.out.println("2번 물통 값 : " + temp.readValue());
			Logger.info("2번 물통 정보 : {} / {} / {} / {}", Integer.parseInt(secondWaterConfig[0]), Integer.parseInt(secondWaterConfig[1]), Integer.parseInt(secondWaterConfig[2]), Double.parseDouble(secondWaterConfig[3]));
		}
		
		temp = new Hx711(Integer.parseInt(firstWaterConfig[0]), Integer.parseInt(thirdWaterConfig[1]), Integer.parseInt(thirdWaterConfig[2]), Double.parseDouble(thirdWaterConfig[3]));
		if (temp != null) {
			temp.measureAndSetTare();
			waterBarrels.add(temp);
			System.out.println("3번 물통 값 : " + temp.readValue());
			Logger.info("3번 물통 정보 : {} / {} / {} / {}", Integer.parseInt(thirdWaterConfig[0]), Integer.parseInt(thirdWaterConfig[1]), Integer.parseInt(thirdWaterConfig[2]), Double.parseDouble(thirdWaterConfig[3]));
		}
		
		Logger.info("hx711 센서들 초기화 완료!!!");
	}
	
	public List<FeedBarrel> getFeedBarrels() {
		List<FeedBarrel> list = new ArrayList<FeedBarrel>();
		
		for(int i = 0; i < feedBarrels.size(); i++) {
			Hx711 feedSensor = feedBarrels.get(i);
			if (feedSensor != null) {
				FeedBarrel feedBarrel = new FeedBarrel();
				feedBarrel.setNo(i+1);
				feedBarrel.setCapacity(Math.toIntExact(feedSensor.getGramFromValue()));
				
				//gpio가 연결돼있지 않다면
				if (feedSensor.readValue() == 8388608) {
					feedBarrel.setStatus("O");
				} else {
					feedBarrel.setStatus("X");
				}
				
				list.add(feedBarrel);
			}
		}
		
		return list;
	}
	
	public List<WaterBarrel> getWaterBarrels() {
		List<WaterBarrel> list = new ArrayList<WaterBarrel>();
		
		for(int i = 0; i < waterBarrels.size(); i++) {
			Hx711 waterSensor = waterBarrels.get(i);
			if (waterSensor != null) {
				WaterBarrel waterBarrel = new WaterBarrel();
				waterBarrel.setNo(i+1);
				waterBarrel.setCapacity(Math.toIntExact(waterSensor.getGramFromValue()));
				
				//gpio가 연결돼있지 않다면
				if (waterSensor.readValue() == 8388608) {
					waterBarrel.setStatus("O");
				} else {
					waterBarrel.setStatus("X");
				}
				
				list.add(waterBarrel);
			}
		}
		
		return list;
	}
}