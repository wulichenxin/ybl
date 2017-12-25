package cn.sunline.framework.util;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * <p>
 * Title:Arith
 * </p>
 * <p>
 * Description: 由于Java的简单类型不能够精确的对浮点数进行运算，这个工具类提供精 <br/>
 * 确的浮点数运算，包括加减乘除和四舍五入。
 * </p>
 */
public class Arith {

    /** 默认除法运算精度 */
    public static final int DEF_DIV_SCALE = 10;

    /**
     * <p>
     * Title: Arith
     * </p>
     * <p>
     * Description: 这个类不能实例化
     * </p>
     */
    private Arith() {
    }

    /**
     * 提供精确的加法运算。
     * 
     * @param v1
     *            被加数
     * @param v2
     *            加数
     * @return 两个参数的和
     */
    public static BigDecimal add(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.add(b2);
    }

    /**
     * 提供精确的减法运算。
     * 
     * @param v1
     *            被减数
     * @param v2
     *            减数
     * @return 两个参数的差
     */
    public static BigDecimal sub(BigDecimal v1, BigDecimal v2) {
        return v1.subtract(v2);
    }

    /**
     * 提供精确的乘法运算。
     * 
     * @param v1
     *            被乘数
     * @param v2
     *            乘数
     * @return 两个参数的积
     */
    public static BigDecimal mul(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.multiply(b2);
    }

    /**
     * <p>
     * Title: muchmul
     * </p>
     * <p>
     * Description: 精确计算一个数字的N次方
     * </p>
     * 
     * @param b1
     *            底数
     * @param count
     *            指数
     * @return 底数的指数次方
     */
    public static BigDecimal muchmul(BigDecimal b1, int count) {
        BigDecimal b2 = new BigDecimal(Double.toString(1.00));
        if (count == 0) {
            return b2;
        } else if (count == 1) {
            return b1;
        } else if (count > 1) {

            for (int i = 0; i < count; i++) {
                b2 = b2.multiply(b1);
            }
            return b2;
        }

        return b1;

    }

    /**
     * 提供（相对）精确的除法运算，当发生除不尽的情况时，精确到 小数点以后10位，以后的数字四舍五入。
     * 
     * @param v1
     *            被除数
     * @param v2
     *            除数
     * @return 两个参数的商
     */
    public static BigDecimal div(double v1, double v2) {

        return div(v1, v2, DEF_DIV_SCALE);
    }

    /**
     * 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指 定精度，以后的数字四舍五入。
     * 
     * @param v1
     *            被除数
     * @param v2
     *            除数
     * @param scale
     *            表示表示需要精确到小数点以后几位。
     * @return 两个参数的商
     */
    public static BigDecimal div(double v1, double v2, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException("要保留的小数位数必须是一个正整数或者0");
        }
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.divide(b2, scale, RoundingMode.HALF_EVEN);
    }

    /**
     * 提供精确的小数位四舍五入处理。
     * 
     * @param v
     *            需要四舍五入的数字
     * @param scale
     *            小数点后保留几位
     * @return 四舍五入后的结果
     */
    public static BigDecimal round(BigDecimal v, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException("要保留的小数位数必须是一个正整数或者0");
        }
        BigDecimal one = new BigDecimal("1");
        return v.divide(one, scale, RoundingMode.HALF_EVEN);
    }
  
    public static Double getInter(String str){
    	str = str.substring(0, str.indexOf("."));
    	Double i = Double.valueOf(str);
    	return i;
    }
    
    public static void main(String[] args) {
		System.err.println(div(1.00032,2.43243));
		System.err.println(div(1.00032,2.43243,3));
		System.err.println(mul(1.00032,2.43243));
	}
    
}