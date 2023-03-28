package com.notes.dao;

//import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.notes.entities.Post;

public class PostDao {

	Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}

	public boolean savePost(Post p) {
		boolean f = false;
		try {

			String q = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(q);
			pstmt.setString(1, p.getpTitle());
			pstmt.setString(2, p.getpContent());
			pstmt.setString(3, p.getpCode());
			pstmt.setString(4, p.getpPic());
			pstmt.setInt(5, p.getCatId());
			pstmt.setInt(6, p.getUserId());
			pstmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

//    get all the posts
	public List<Post> getAllPosts() {

		List<Post> list = new ArrayList<>();
		// fetch all the post
		try {

			PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");

			ResultSet set = p.executeQuery();

			while (set.next()) {

				int pid = set.getInt("pid");
				String pTitle = set.getString("pTitle");
				String pContent = set.getString("pContent");
				String pCode = set.getString("pCode");
				String pPic = set.getString("pPic");
				Timestamp date = set.getTimestamp("pDate");
				int catId = set.getInt("catId");
				int userId = set.getInt("userId");
				Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

				list.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
