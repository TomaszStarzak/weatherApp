public abstract class ConstantRepository {

    private static final Map<Type, ConstantRepository> typeToSingleton = new Map<Type, ConstantRepository>();

    public static ConstantRepository getSingleton(Type type) {
        if (typeToSingleton.containsKey(type) == false) {
            typeToSingleton.put(type, (ConstantRepository) type.newInstance());
        }
        return typeToSingleton.get(type);
    }

    public class WeatherConstants extends ConstantRepository {
        public final String ERR_MSG_COULD_NOT_FIND_SEARCHED_LOCATION = 'Opsie! Could not find searched location! Please ensure that you entered a correct location.'; // ToDo move to custom labels
    }
}