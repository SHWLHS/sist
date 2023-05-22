package com.score;

import java.sql.SQLException;
import java.util.List;

public interface ScoreDAO {
	public void insertScore(ScoreDTO dto) throws SQLException;
	public void updateScore(ScoreDTO dto) throws SQLException;
	public void deleteScore(String hak) throws SQLException;
	public void deleteScore(String[] haks) throws SQLException;
	
	public int dataCount();
	public List<ScoreDTO> listScore();
	public List<ScoreDTO> listScore(int offset, int size);
	public ScoreDTO readScore(String hak);
	
	
}
