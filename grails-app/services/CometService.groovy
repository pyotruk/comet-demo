class CometService {

    static scope = "request"

    void run() {
        100.times {
            sleep(50)
            pushProgress(it + 1)
        }
    }

    private void pushProgress(Long progress) {
        event(
                topic: 'progress',
                data: [
                        progress: progress
                ]
        )
    }

}
