package util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import dao.UserDao;

public class BatchAddUsers {
	static Random rand;
	static String filename = "./res/users.csv";
	static String outputfile = "./res/password.csv";
	public static void addUsers() {
		File f = new File(filename);
		System.out.println(f.getAbsolutePath());
		boolean formatFalse = false;
		ArrayList<String> nums = new ArrayList<String>();
		ArrayList<String> names = new ArrayList<String>();
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(
					new FileInputStream(filename), "UTF-8"));
			String tmp = "";
			while ((tmp = br.readLine()) != null) {
				tmp = tmp.trim();
				
				if (!tmp.contains(",")) { // 判断是否有逗号
					formatFalse = true;
					break;
				} else { // 判断是否只有一个逗号
					int count = 0;
					for (int i = 0; i < tmp.length(); i ++) {
						String s = tmp.substring(i, i+1);
						if (s.equals(",")) {
							count ++;
						}
					}
					if (count > 1) {
						formatFalse = true;
						break;
					}
				}
				String[] slist = tmp.split(",");
				
				Integer testInt = Integer.parseInt(slist[0]);
				nums.add(slist[0]);
				names.add(slist[1]);
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			formatFalse = true;
			System.out.println("格式错误1");
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			formatFalse = true;
			System.out.println("格式错误2");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			formatFalse = true;
			System.out.println("格式错误3");
		} catch (NumberFormatException e) {
			formatFalse = true;
			System.out.println("格式错误4");
		}
		
		if (formatFalse) {
			System.out.println("格式错误！");
		} else {
			add(nums, names);
		}
	}
	
	public static void add(ArrayList<String> numbers, ArrayList<String> names) {
		//TODO add
		HashMap<String, String> map = new HashMap<String, String>();
		for (int i = 0; i < numbers.size(); i ++) {
			map.put(numbers.get(i), getRandomPW(10));
		}
		try {
			FileWriter writer = new FileWriter(outputfile);
			for (int i = 0; i < numbers.size(); i ++) {
				String studentnum = numbers.get(i);
				String name = names.get(i);
				UserDao userDao = new UserDao();
				if (studentnum != null && !studentnum.isEmpty())
				{
					if(userDao.userIsExist(studentnum))
					{
						User user = new User();
						user.setStudentnum(studentnum);
						user.setName(name);
						user.setUserType(0);
						userDao.saveUser(user);
						writer.write(numbers.get(i) + "," + map.get(numbers.get(i)) + "\n");
					}else
					{
						writer.write(numbers.get(i) + ",用户名已存在" + "\n");
					}
				}
				
				
				
			}
			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public static String getRandomPW(int length) {
		if (rand == null) {
			rand = new Random(System.currentTimeMillis());
		}
		String ret = "";
		for (int i = 0; i < length; i ++) {
			int x = rand.nextInt(26*2);
			char c = 'a';
			if (x > 25) {
				x = x - 26 + 97;
				c = (char)x;
			} else {
				x = x + 65;
				c = (char)x;
			}
			
			ret += c;
		}
		return ret;
	}
	
	public static  void main(String args[]) {
		Random rand = new Random(System.currentTimeMillis());
		for (int i = 0; i < 100; i ++) {
			//System.out.println(rand.nextInt(4));
			//System.out.println(getRandomPW(15));
		}
		addUsers();
	}
}
