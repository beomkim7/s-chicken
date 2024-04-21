package com.groups.schicken.annual;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.Temporal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.groups.schicken.Employee.EmployeeService;
import com.groups.schicken.Employee.EmployeeVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class) // error 났을때 rollbac설정
public class AnnualService {

	@Autowired
	private AnnualDAO annualDAO;

	//@Scheduled(cron = "0 * * * * ?") // 1분
	@Scheduled(cron = "0 0 0 1 * *") // 매월 1일 0시 0분 0초에 실행
	public void updateAnnualLeaves() throws Exception {
	    LocalDate today = LocalDate.now(); // 오늘 날짜
	    if (today.getYear() == 2024) { // 올해가 2024년인 경우에만 실행
	        List<EmployeeVO> employeeList = annualDAO.list(); // 모든 직원 목록 가져오기
	        String msg = "연차 제공";
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
	        for (EmployeeVO employeeVO : employeeList) {
	            LocalDate dateOfEmployment = LocalDate.parse(employeeVO.getDateOfEmployment(), formatter);
	            long yearsOfService = dateOfEmployment.until(today).getYears(); // 근속 연수 계산
	            int annualLeavesToGrant = (yearsOfService >= 3) ? 2 : 1; // 3년 이상이면 2개, 그렇지 않으면 1개

	            if (dateOfEmployment.plusMonths(1).isBefore(today)) { // 입사 후 최소 1달이 지난 경우에만 지급
	                AnnualVO annualVO = new AnnualVO();
	                annualVO.setEmployeeId(employeeVO.getId());
	                annualVO.setRemainderAnnual(annualLeavesToGrant);
	                annualVO.setHistory(msg);
	                String date = String.format("%04d%02d%02d", today.getYear(), today.getMonthValue(), 1);
	                annualVO.setAnnualDate(date);

	                // 연차 정보 DB에 저장
	                int result = annualDAO.annualInsert(annualVO);
	            }
	        }
	    }
	}

	public int annualInsert(AnnualVO annualVO) throws Exception {
		LocalDate today = LocalDate.now();
		String date = String.format("%04d%02d%02d", today.getYear(), today.getMonthValue(), today.getDayOfMonth());
		annualVO.setAnnualDate(date);
		Integer s = annualVO.getRemainderAnnual();
		if (s <= 0) {
			annualVO.setAnnual(s);
		}
		Integer totla = annualVO.getRemainderAnnual() - annualVO.getAnnual();
		annualVO.setAnnualTotal(totla);
		int result = annualDAO.annualInsert(annualVO);

		return result;
	}

	public List<AnnualVO> annualList(AnnualVO annualVO) throws Exception {
		// 기존 메서드 구현을 그대로 유지하고, 새로운 기능을 추가
		List<AnnualVO> annualList = annualDAO.annualList(annualVO);
		return calculateRemainingAnnual(annualList);
	}

	private List<AnnualVO> calculateRemainingAnnual(List<AnnualVO> annualList) {
		List<AnnualVO> resultList = new ArrayList<>();

		int remainderAnnual = 0;
		for (AnnualVO annual : annualList) {
			int receivedAnnual = annual.getRemainderAnnual(); // 받은 연차
			int usedAnnual = annual.getAnnual(); // 사용한 연차

			remainderAnnual += (receivedAnnual - usedAnnual); // 남은 연차 계산

			annual.setAnnualTotal(remainderAnnual);
			resultList.add(annual);
		}

		return resultList;
	}

}
