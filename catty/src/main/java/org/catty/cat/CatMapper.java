package org.catty.cat;

import java.util.List;

/**
 * @author dbsehdghks45@naver.com
*/
public interface CatMapper {
    public List<Cat> selectCatList(String term, int sort) throws Exception;
    public Cat selectCat(Cat cat) throws Exception;
    public int insertCat(Cat cat) throws Exception;
    public int updateCat(Cat cat) throws Exception;
    public int deleteCat(Cat cat) throws Exception;
}