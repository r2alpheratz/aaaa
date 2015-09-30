package com.korail.tz.sa;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Map;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Service;


@Service("cosmos.asset.ImageSVC")
public class ImageSVC {
	public ByteArrayOutputStream generate(@SuppressWarnings("rawtypes") final Map param) throws IOException{
		final ByteArrayOutputStream out = new ByteArrayOutputStream();
		
		final BufferedImage image = new BufferedImage(400, 300, BufferedImage.TYPE_INT_RGB);
		final Graphics2D graphic = image.createGraphics();
	
		graphic.setBackground(Color.white);
		graphic.setColor(Color.white);
		graphic.fillRect(0, 0, 400, 300);
		
		graphic.setColor(Color.black);
		graphic.drawString("abc", 10, 10);
		
		ImageIO.write(image, "gif", out);
		graphic.dispose();
		
		out.flush();
		out.close();
		
		return out;
	}
}
