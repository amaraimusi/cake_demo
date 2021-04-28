<?php
App::uses('AppController', 'Controller');
class UsersController extends AppController {

	public function beforeFilter() {
		parent::beforeFilter();
//		$this->Auth->allow('add');
	}

	public function login() {
		if ($this->request->is('post')) {
			if ($this->Auth->login()) {
				$this->redirect('/');
			} else {
				$this->Session->setFlash(__('ユーザー名、またはパスワードを間違ています。<br>Invalid username or password, try again'));
			}
		}
		$this->layout = '';
	}

	public function logout() {
		$this->log($this->Auth->logout());
		$this->redirect('login');
		
	}

	public function index() {

		$this->User->recursive = 0;
		$this->set('users', $this->paginate());
	}

	public function view($id = null) {


		$this->User->id = $id;
		if (!$this->User->exists()) {
			throw new NotFoundException(__('Invalid user'));
		}
		$this->set('user', $this->User->read(null, $id));
	}

	public function add() {

		if ($this->request->is('post')) {
			$this->User->create();
			if ($this->User->save($this->request->data)) {
				$this->Session->setFlash(__('The user has been saved'));
				$this->redirect('/');
			} else {
				$this->Session->setFlash(__('The user could not be saved. Please, try again.'));
			}
		}
	}

	public function edit($id = null) {

		$this->User->id = $id;
		if (!$this->User->exists()) {
			throw new NotFoundException(__('Invalid user'));
		}
		if ($this->request->is('post') || $this->request->is('put')) {
			if ($this->User->save($this->request->data)) {
				$this->Session->setFlash(__('The user has been saved'));
				$this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The user could not be saved. Please, try again.'));
			}
		} else {
			$this->request->data = $this->User->read(null, $id);
			unset($this->request->data['User']['password']);
		}
	}

	public function delete($id = null) {

		if (!$this->request->is('post')) {
			throw new MethodNotAllowedException();
		}
		$this->User->id = $id;
		if (!$this->User->exists()) {
			throw new NotFoundException(__('Invalid user'));
		}
		if ($this->User->delete()) {
			$this->Session->setFlash(__('User deleted'));
			$this->redirect(array('action' => 'index'));
		}
		$this->Session->setFlash(__('User was not deleted'));
		$this->redirect(array('action' => 'index'));
	}
	
	
	/**
	 * パスワード入力なしの自動ログイン（localhostのみ）
	 */
	public function test(){
		if($_SERVER['SERVER_NAME'] != 'localhost'){
			echo 'localhost only!';
			die();
		}

		$id = 4; // ログイン対象のユーザーID
		
		// ユーザーエンティティ
		$user = $this->User->find('first', [
				'conditions' => ['User.id' => $id],
				'recursive' => -1
				]
			);
		
		
		// パスワードは削除
		unset($user['User']['password']);
		
		// ログインする。
		if ($this->Auth->login($user['User'])) {
			echo 'login success';
		}else{
			
			echo 'login false';
		}
		die();
	}
	
}