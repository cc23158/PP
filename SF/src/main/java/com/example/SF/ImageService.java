package com.example.SF;

import okhttp3.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

@Service
public class ImageService {
    @Value("${supabase.url}")
    private String supabaseUrl;

    @Value("${supabase.apiKey}")
    private String supabaseApiKey;

    @Value("${supabase.bucket.name}")
    private String bucketName;

    public String uploadImage(MultipartFile imageFile){
        try {
            OkHttpClient client = new OkHttpClient();

            File tempFile = File.createTempFile("upload-", imageFile.getOriginalFilename());
            imageFile.transferTo(tempFile);

            RequestBody requestBody = new MultipartBody.Builder()
                    .setType(MultipartBody.FORM)
                    .addFormDataPart("file", imageFile.getOriginalFilename(),
                            RequestBody.create(tempFile, MediaType.parse(imageFile.getContentType())))
                    .build();

            Request request = new Request.Builder()
                    .url(supabaseUrl + "/storage/v1/object/" + bucketName + "/" + imageFile.getOriginalFilename())
                    .addHeader("Authorization", "Bearer " + supabaseApiKey)
                    .post(requestBody)
                    .build();

            try (Response response = client.newCall(request).execute()) {
                if (!response.isSuccessful()) {
                    System.out.println("Upload failed: " + response.message());
                    return "";
                }
                return supabaseUrl + "/storage/v1/object/" + bucketName + "/" + imageFile.getOriginalFilename();
            }

        }

        catch (Exception e){
            System.out.println("Cannot insert image: " + e.getMessage());
            return "";
        }
    }
}