package board.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api")
public class UploadController {
	private static final String UPLOAD_DIR = "C:/uploads/"; 
	
	@PostMapping("/uploadImage")
    public Map<String, Object> uploadImage(@RequestParam("file") MultipartFile file,HttpServletRequest request) throws IOException {
        Map<String, Object> result = new HashMap<>();
        
        File dir = new File(UPLOAD_DIR);
        if(!dir.exists()){
        	dir.mkdir();
        }
        
        try {
            String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
            File uploadPath = new File(dir,filename);
            //File uploadPath = new File(dir,file.getOriginalFilename());
            file.transferTo(uploadPath);
            String fileUrl = request.getContextPath() + "/uploads/" + filename;
            System.out.println("callback url = " + fileUrl);
            result.put("success", true);
            result.put("url",fileUrl);
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        return result;
    }
}
