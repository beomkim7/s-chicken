package com.groups.schicken.util;

import com.groups.schicken.aws.S3Service;
import com.groups.schicken.common.vo.FileVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@Component
public class FileManager {
    @Autowired
    private S3Service s3Service;
    @Autowired
    private FileMapper fileMapper;

    public boolean uploadFile(MultipartFile file, FileVO fileVO) throws Exception{
        String uid = UUID.randomUUID().toString();
        fileVO.setName(uid);
        fileVO.setOriginName(file.getOriginalFilename());
        fileVO.setExtension(file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1));
        s3Service.uploadFile(file, fileVO);
        fileMapper.uploadFile(fileVO);
        return true;
    }
    public boolean deleteFile(FileVO fileVO) throws Exception {
        fileMapper.deleteFile(fileVO);
        return s3Service.deleteFile(fileVO);
    }
    public List<FileVO> getFiles() {
        return null;
    }
}
