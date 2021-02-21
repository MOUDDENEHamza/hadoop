package ordo;

import java.io.Serializable;
import java.util.concurrent.Semaphore;

/**
 * Reminder called when the execution of map is done
 *
 * @author Hamza Mouddene
 * @version 1.0
 */
public class CallBack implements Serializable {

    /**
     * Attributes of Callback class
     */
    private final Semaphore semaphore;        // The semaphore we will use

    /**
     * Constructor of Callback class
     */
    public CallBack() {
        this.semaphore = new Semaphore(0);
    }

    public Semaphore getSemaphore() {
        return this.semaphore;
    }

    /**
     * When the task is done, we increment the counter then if the counter is equal to the number of available fragments
     * it prevents that the process has finished
     */
    public void runMapDone() {
        try {
            System.out.println("map done");
            this.getSemaphore().release();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void waitForFinished() {
        try {
            System.out.println("wait map");
            this.getSemaphore().acquire();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
