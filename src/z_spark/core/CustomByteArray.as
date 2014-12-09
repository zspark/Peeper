package z_spark.core
{
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class CustomByteArray extends ByteArray
    {
        public function CustomByteArray()
        {
            this.endian = Endian.BIG_ENDIAN;
        }
    }
}
