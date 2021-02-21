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
    private int count;
    private final int nbChunks;

    /**
     * Constructor of Callback class
     *
     * @param nbChunks the total number of fragments
     */
    public CallBack(int nbChunks) {
        this.semaphore = new Semaphore(0);
        this.count = 0;
        this.nbChunks = nbChunks;
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
            if (this.count == this.nbChunks) {
                this.getSemaphore().release();
            } else {
                this.count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
