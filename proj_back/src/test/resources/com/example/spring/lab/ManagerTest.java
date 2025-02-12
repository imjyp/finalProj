package com.example.spring.lab;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.example.demo.collection.Manager;
import com.example.demo.collection.People;
import com.example.demo.collection.Student;

public class ManagerTest {
	public static void main(String[] args) {
//		ApplicationContext context = new ClassPathXmlApplicationContext(
//				new String[]{"com/example/spring/lab/beans-manager.xml"});
//		ApplicationContext context = new ClassPathXmlApplicationContext(
//				new String[]{"com/example/spring/lab/beans-aspect.xml"});
		
		ApplicationContext context = new ClassPathXmlApplicationContext(
				new String[]{"com/example/spring/lab/beans-aspect2.xml"});
		
		Manager manager = (Manager)context.getBean("manager");
		
		System.out.println(manager);
		manager.printPeopleList();
		
		People people = new Student();
		people.setName("강감찬");
		
		People findPeople=manager.retrieve(people);
		System.out.println("findPeople: "+findPeople);
		
		
		people = new Student("강감찬", "14", "여자", "3", "11", "3");
		int cnt = manager.update(people);
		System.out.println("cnt: "+cnt);		
		
		findPeople=manager.retrieve(people);
		System.out.println("findPeople: "+findPeople);
		
		System.out.println(manager.delete(people));
		manager.printPeopleList();
	}
}
